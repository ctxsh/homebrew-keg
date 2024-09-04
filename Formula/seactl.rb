class Seactl < Formula
  desc "Manage development environments in kubernetes"
  homepage "https://github.com/ctxswitch/seaway"
  url "https://github.com/ctxswitch/seaway/archive/refs/tags/v0.1.0-pre.14.tar.gz"
  sha256 "fdb3ed40a8fc526878a29b3fc7f0c6a85f4fa542ad9acafce3b2a11ae8780014"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/ctxsh/homebrew-tap/releases/download/seactl-0.1.0-pre.14"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "8ee39992a87b2836a6fb814367d6ae924fcd996e243a3a88e80796d31baac7ca"
    sha256 cellar: :any_skip_relocation, ventura:      "ba2b8a16313fc8164d266810b0622b137b4bcbbc11218316a7ad4c3784307a43"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3b3c2175c82cd9c053eac3cb7948c830901216a9be6ff5ab5b1608185ca5c726"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X ctx.sh/seaway/pkg/build.Version=#{version}
    ]

    system "go", "build", "-trimpath", *std_go_args(ldflags:), "./pkg/cmd/seactl"

    generate_completions_from_executable(bin/"seactl", "completion")
  end

  test do
    assert_match "seactl version #{version}", shell_output("#{bin}/seactl --version").strip
  end
end
