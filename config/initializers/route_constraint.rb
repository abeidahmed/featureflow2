class AppSubdomainConstraint
  def self.matches?(request)
    request.subdomain.present? && request.subdomain == "app"
  end
end
