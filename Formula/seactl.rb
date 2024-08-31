class Seactl < Formula
  desc "Manage development environments in kubernetes"
  homepage "https://github.com/ctxswitch/seaway"
  url "https://github.com/ctxswitch/seaway/archive/refs/tags/v0.1.0-pre.12"
  sha256 "ff129de5590b139e9fd33de684bf42eb058af84df2e73058477a13a416042d18"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/ctxsh/homebrew-tap/releases/download/seactl-0.1.0-pre.11"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "8cc168df8aa448b27580ff6f2398fcd372fa13ef73e5b22c757e361dcb445860"
    sha256 cellar: :any_skip_relocation, ventura:      "fbbfe6d8afecb4bbd27eca7507d316c9096473a1af49b2bab18172ec7602796a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2634416859fd180ee8320977ccc9d06b33396e3c317acb3db386164f774106d3"
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
