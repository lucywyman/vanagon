project "my-app" do |proj|
  # Project level settings our components will care about
  proj.setting(:prefix, "/opt/my-app")
  proj.setting(:sysconfdir, "/etc/my-app")
  proj.setting(:logdir, "/var/log/my-app")
  proj.setting(:bindir, File.join(proj.prefix, "bin"))
  proj.setting(:libdir, File.join(proj.prefix, "lib"))
  proj.setting(:includedir, File.join(proj.prefix, "include"))
  proj.setting(:datadir, File.join(proj.prefix, "share"))
  proj.setting(:mandir, File.join(proj.datadir, "man"))
  proj.setting(:artifactory_url, "https://artifactory.delivery.puppetlabs.net/artifactory")
  proj.setting(:buildsources_url, "#{proj.artifactory_url}/generic/buildsources")

  if platform.is_windows?
    proj.setting(:company_name, "BananaLand Inc.")
    proj.setting(:company_id, "BananaLand")
    proj.setting(:common_product_id, "MyAppInstaller")
    proj.setting(:service_name, "my-app-service")
    proj.setting(:product_id, "my-app")
    proj.setting(:upgrade_code, "SOME_GUID")
    if platform.architecture == "x64"
      proj.setting(:win64, "yes")
    else
      proj.setting(:win64, "no")
    end
  end

  proj.description "This app does some things."
  proj.version "1.2.3"
  proj.license "ASL 2.0"
  proj.vendor "Me <info@my-app.com>"
  proj.homepage "https://www.my-app.com"
  proj.requires "glibc"

  proj.component "component1"
  proj.component "component2"

  # Here we rewrite public http urls to use our internal source host instead.
  # Something like https://www.openssl.org/source/openssl-1.0.0r.tar.gz gets
  # rewritten as
  # https://artifactory.delivery.puppetlabs.net/artifactory/generic/buildsources/openssl-1.0.0r.tar.gz
  #
  # @deprecated 2017-04-07 - Ryan McKern
  #   This functionality has been replaced with Component Mirrors. This feature 
  #   will be removed before Vanagon 1.0.0, but for now it will add all rewritten
  #   URLs/URIs to the list of mirrors
  #
  # proj.register_rewrite_rule 'http', proj.buildsources_url

  # Here we rewrite public git urls to use our internal git mirror It turns
  # urls that look like git://github.com/puppetlabs/puppet.git into
  # git://github.delivery.puppetlabs.net/puppetlabs-puppet.git
  #
  # @deprecated 2017-04-07 - Ryan McKern
  #   This functionality has been replaced with Component Mirrors. This feature 
  #   will be removed before Vanagon 1.0.0, but for now it will add all rewritten
  #   URLs/URIs to the list of mirrors
  #
  # proj.register_rewrite_rule 'git', Proc.new { |url|
  #   match = url.match(/github.com\/(.*)$/)
  #   "git://github.delivery.puppetlabs.net/#{match[1].gsub('/', '-')}" if match
  # }

  # directory adds a directory (and its contents) to the package that is created
  proj.directory proj.prefix
  proj.directory proj.sysconfdir
  proj.directory proj.logdir
end
