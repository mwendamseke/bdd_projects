unless File.exists?( File.join(Rails.root, 'public', 'courgette') )
  raise "cant not find courgette public assets, pls read the courgette plugin README.rdoc to learn how to add symlink manually"
end