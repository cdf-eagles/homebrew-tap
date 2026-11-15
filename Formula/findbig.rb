class Findbig < Formula
  include Language::Python::Shebang

  desc "List the largest files and directories under a directory"
  homepage "https://github.com/cdf-eagles/py-findbig"
  url "https://github.com/cdf-eagles/py-findbig/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "bb2fe394fafdbd31979cd2211bcfbcf93b517c86267a60be8f244931f3576483"
  license "BSD-3-Clause"

  depends_on "python@3.15"

  def install
    rewrite_shebang detected_python_shebang, "findbig.py"
    bin.install "findbig.py" => "findbig"
    man1.install "docs/findbig.1"
  end

  test do
    assert_equal "findbig v#{version}", shell_output("#{bin}/findbig --version").strip

    (testpath/"tree").mkpath
    (testpath/"tree/big.bin").write("x" * 65_536)
    (testpath/"tree/small.txt").write("x")
    entries = JSON.parse(shell_output("#{bin}/findbig --json -n 2 #{testpath}/tree"))
    assert_equal "big.bin", File.basename(entries[1]["path"])
    assert_equal 65_536, entries[1]["size_bytes"]
  end
end
