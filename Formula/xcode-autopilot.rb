class XcodeAutopilot < Formula
  desc "MCP server that gives AI the ability to build, test, and fix Xcode errors autonomously"
  homepage "https://leejh08.github.io/XcodeAutoPilot/"
  url "https://github.com/leejh08/XcodeAutoPilot/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "e2b108cdb575a9a107056afd8d84287c3978cc345b60670e96ee9f816d6ee47a"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "ci"
    system "npm", "run", "build"

    libexec.install "dist", "node_modules", "package.json"

    (bin/"xcode-autopilot").write <<~EOS
      #!/bin/bash
      exec node "#{libexec}/dist/index.js" "$@"
    EOS
  end

  test do
    output = shell_output("#{bin}/xcode-autopilot 2>&1", 1)
    assert_match "XcodeAutoPilot", output
  end
end
