class XcodeAutopilot < Formula
  desc "MCP server that gives AI the ability to build, test, and fix Xcode errors autonomously"
  homepage "https://leejh08.github.io/XcodeAutoPilot/"
  url "https://github.com/leejh08/XcodeAutoPilot/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "3226fc388c21aee1c36a47205427d540821ae9e25d3c0eae43df1ce829b9ea8f"
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
