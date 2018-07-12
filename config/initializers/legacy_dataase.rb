Rails.configuration.x.legacy = YAML.load(ERB.new(IO.read(Rails.root.join("config","database_legacy.yml"))).result)
