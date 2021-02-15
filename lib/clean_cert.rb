# frozen_string_literal: true

def clean_cert(cert)
  cert
    .gsub(/(-----(BEGIN|END) (CERTIFICATE|PRIVATE KEY)-----|\n)/, '')
    .gsub(/\n/, '')
end
