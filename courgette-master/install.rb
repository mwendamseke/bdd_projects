puts "Courgette install script is adding a symlink to courgette/public/courgette inside your application's public directory"
`cd public;ln -s ../vendor/plugins/courgette/public/courgette courgette`