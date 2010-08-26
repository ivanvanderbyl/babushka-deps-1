dep 'mongrel.gem' do
  provides 'mongrel_rails'
end

dep 'monit mongrels configured' do
  requires 'mongrel.gem'
  helper(:monitrc) { "/etc/monit/conf.d/mongrel.#{var(:app_name)}.monitrc" }
  met? { sudo "grep 'Generated by babushka' #{monitrc}" }
  meet { render_erb "monit/mongrels.monitrc.erb", :to => monitrc, :sudo => true }
  after {
    sudo "monit reload"
    sudo "monit restart all -g mongrel_#{var(:app_name)}"
  }
end
