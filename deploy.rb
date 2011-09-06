dep 'pre-receive' do
  requires 'benhoskings:ready for update.repo'
end

dep 'post-receive' do
  define_var :app_env, :default => :production
  define_var :app_root, :default => '.'
  requires [
    'benhoskings:ref info extracted.repo',
    'benhoskings:branch exists.repo',
    'benhoskings:branch checked out.repo',
    'benhoskings:HEAD up to date.repo',
    'benhoskings:app bundled',

    # This and the 'maintenace' one below are separate so the 'current dir'
    # deps load lazily from the new code checked out by 'HEAD up to date.repo'.
    'on deploy',

    'benhoskings:app flagged for restart.task',
    'benhoskings:maintenance page down',
    'after deploy'
  ]
end

# These are looked up with Dep() so they're just skipped if they don't exist.
dep 'on deploy' do
  requires Dep('current dir:on deploy')
end
dep 'after deploy' do
  requires Dep('current dir:after deploy')
end
