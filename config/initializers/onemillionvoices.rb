# frozen_string_literal: true

CONFIG = YAML.load_file("#{Rails.root}/config/onemillionvoices.yml")

Time::DATE_FORMATS[:default] = "%d/%m/%Y %H:%M"
Date::DATE_FORMATS[:default] = "%d/%m/%Y"
