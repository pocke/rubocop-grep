D = Steep::Diagnostic

target :lib do
  signature "sig"

  check "lib"
  configure_code_diagnostics(D::Ruby.all_error) do |hash|
    hash[D::Ruby::MethodDefinitionMissing] = :hint
  end
end
