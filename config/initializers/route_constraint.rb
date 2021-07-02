class AppSubdomainConstraint
  def self.matches?(request)
    request.subdomains.present? && request.subdomains.last == "app"
  end
end
