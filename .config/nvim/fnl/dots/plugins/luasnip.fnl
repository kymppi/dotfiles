(module dots.plugins.luasnip
  {autoload {a aniseed.core
             luasnip luasnip}})

(let [t luasnip.text_node
      s luasnip.snippet]
  (luasnip.add_snippets 
    :rust
    [(luasnip.snippet "readints"
                      [(luasnip.text_node 
                         ["#[macro_export]"
                          "macro_rules! readints {"
                          "    ($x:ident,$y:ident) => {{"
                          "        x.read_line(&mut$y).unwrap();"
                          "        let nums = $y"
                          "            .trim()"
                          "            .split_whitespace()"
                          "            .map(|s| s.parse::<i32>().unwrap())"
                          "            .collect::<Vec<_>>();"
                          "        $y.clear();"
                          "        nums"
                          "    }};"
                          "}"])])
     (luasnip.snippet "is_prime"
                      [(luasnip.text_node 
                         ["fn is_prime<T: Into<i64>>(n: T) -> bool {"
                          "    let n: i64 = n.into();"
                          "    match n {"
                          "        1 => false,"
                          "        2 | 3 => true,"
                          "        n if n % 2 == 0 => false,"
                          "        n => !(3..)"
                          "            .step_by(2)"
                          "            .take_while(|i| i * i <= n)"
                          "            .any(|i| n % i == 0),"
                          "    }"
                          "}"])])
     (luasnip.snippet "mainstdin"
                      [(luasnip.text_node
                         ["fn main() {"
                          "    let mut stdin = std::io::stdin();"
                          "    let mut input = String::new();"
                          "    stdin.read_line(&mut input).unwrap();"
                          "}"])])]))
