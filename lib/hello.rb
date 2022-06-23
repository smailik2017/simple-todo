class Hello
  def self.touch
    FileUtils.touch Rails.root.join('tmp/hello_from_ror.txt')
  end

  def self.remove_files
    FileUtils.remove_file Rails.root.join('tmp/hello_from_ror.txt')
  end
end
