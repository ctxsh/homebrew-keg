class Genie < Formula
  desc "Templatable generator for predictable events"
  homepage "https://github.com/ctxswitch/genie"
  url "https://github.com/ctxswitch/genie/archive/refs/tags/v0.1.8.tar.gz"
  sha256 "4c9532ab8aed0749fff98aad92e294b25fe24dfae5845b291166f0c74a96133e"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/ctxsh/homebrew-tap/releases/download/genie-0.1.8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "48bfaa215c8bca30d3f9626cda6009a9f26c8d739257fc519cf13fd08481fbb7"
    sha256 cellar: :any_skip_relocation, ventura:      "da96eb90fd7dd92137cd2b7dca9ce51a65fd655c9f682189c7c654cdfe89ea91"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ec7395a6e0637e945c2def9b8754d2d972098d715fbf5d686bc7ca19aad09f7f"
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
