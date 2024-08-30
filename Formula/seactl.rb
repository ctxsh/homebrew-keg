class Seactl < Formula
  desc "Manage development environments in kubernetes"
  homepage "https://github.com/ctxswitch/seaway"
  url "https://github.com/ctxswitch/seaway/archive/refs/tags/v0.1.0-pre.11.tar.gz"
  sha256 "e4e9a29cf2ad386dc1778d39971c49621c295aa9c7039d8d3f419c8494e4a8ac"
  license "Apache-2.0"

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
