dep 'rails app db yaml present' do
  helper :db_yaml do
    (var(:rails_root) / "config" / "database.yml")
  end
  met? { db_yaml.exists? }
  meet { shell "cp #{var(:rails_root) / "config" / "database.*#{var(:rails_env)}*"} #{db_yaml}" }
end

dep 'bundler installed and locked' do
  requires 'bundler.gem'
  met? { (var(:rails_root) / "Gemfile.lock").exists? && in_dir(var(:rails_root)) { shell "bundle check" } }
  meet { in_dir(var(:rails_root)) { shell "bundle install --relock" }}
end

dep 'bundler.gem' do
  provides 'bundle'
end
