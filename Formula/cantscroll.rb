class Cantscroll < Formula
  desc "Coding-agent-aware phone blocker for developers"
  homepage "https://cantscroll.com"
  version "0.1.4"
  url "https://github.com/cantscroll/cantscroll/releases/download/v0.1.4/cantscroll-0.1.4-macos-universal.zip"
  sha256 "753ba42669581b1f17e37556e4a255d1d7bb1af0408235388b2eba9cdcfd778d"
  depends_on :macos

  def install
    bin.install "cantscroll"
    bin.install "cantscrolld"
    (prefix/"distribution").install "com.cantscroll.agent.plist"
  end

  service do
    run [opt_bin/"cantscrolld"]
    keep_alive true
    log_path var/"log/cantscroll/agent.log"
    error_log_path var/"log/cantscroll/agent.log"
    environment_variables HOME: Dir.home
  end

  def post_install
    system opt_bin/"cantscroll", "setup", "--non-interactive"
  end

  test do
    assert_predicate bin/"cantscroll", :exist?
    assert_predicate bin/"cantscrolld", :exist?
  end
end
