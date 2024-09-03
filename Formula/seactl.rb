class Seactl < Formula
  desc "Manage development environments in kubernetes"
  homepage "https://github.com/ctxswitch/seaway"
  url "https://github.com/ctxswitch/seaway/archive/refs/tags/v0.1.0-pre.13.tar.gz"
  sha256 "9e826d1057c07dc9fdd20af5f8c8c13ca6d1f0df62fb9797d478e65fea34e91c"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/ctxsh/homebrew-tap/releases/download/seactl-0.1.0-pre.13"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "b0afe6f48dd3b67b09759e26aca3cb0c2c10a261e7d63e29c1996bcbed609e00"
    sha256 cellar: :any_skip_relocation, ventura:      "4f0577bec580834b98f864b7005161cc1ced314f04800bcb5eb3918a4d31680d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3d8f67a0b10224916a5c27f6f33b1660f9b19080f3c0573ddaa9a197b6ba6211"
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
