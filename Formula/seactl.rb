class Seactl < Formula
  desc "Manage development environments in kubernetes"
  homepage "https://github.com/ctxswitch/seaway"
  url "https://github.com/ctxswitch/seaway/archive/refs/tags/v0.1.0-pre.12.tar.gz"
  sha256 "ff129de5590b139e9fd33de684bf42eb058af84df2e73058477a13a416042d18"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/ctxsh/homebrew-tap/releases/download/seactl-0.1.0-pre.12"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "8e3228499a152d7423f71fc777578779d8a167752e3a1e87ae0f77ddf9ce04b2"
    sha256 cellar: :any_skip_relocation, ventura:      "521dba7a50c54ae6161f90447ec80d4406217aa7970ac6e231905d5fdd21abb5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2cbdb6bd6fae7a4374a0ca7c7095cea9344156da9192a32bb173b539125eb0f3"
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
