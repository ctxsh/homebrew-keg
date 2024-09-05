class Genie < Formula
  desc "Templatable generator for predictable events"
  homepage "https://github.com/ctxswitch/genie"
  url "https://github.com/ctxswitch/genie/archive/refs/tags/v0.1.7.tar.gz"
  sha256 "dc2b0ccf0802d9e4091f3700d51e7653056103f560cbaf4b8aefff795c765469"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/ctxsh/homebrew-tap/releases/download/genie-0.1.6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "d1d73040d4f5fb4753c0c553cfc65d207ad39b6b62076ff48aef61f5f6572961"
    sha256 cellar: :any_skip_relocation, ventura:      "ec4659abc38a214b81578ed47a0c17060377db165e5501a5b88e4e6bf46ea091"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d5523d2ce86fae46d26da206593f24aaa4a81c8855ca6076ec77b62cc1ae380f"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X ctx.sh/genie/pkg/build.Version=#{version}
    ]

    system "go", "build", "-trimpath", *std_go_args(ldflags:), "main.go"

    generate_completions_from_executable(bin/"genie", "completion")
  end

  test do
    assert_match "genie version #{version}", shell_output("#{bin}/genie --version").strip
  end
end
