use dom_smoothie::{Readability, TextMode};
use std::{env, fs::read_to_string};
use url::Url;

fn main() -> anyhow::Result<()> {
    let args: Vec<String> = env::args().collect();
    let mut uri = None;
    let mut text_mode: TextMode = TextMode::Formatted;
    for arg in args.into_iter().skip(1) {
        if arg == "--markdown" {
            text_mode = TextMode::Markdown;
        } else {
            uri = Some(arg);
        }
    }

    let uri = uri.expect("Failed to get the URL or path to the HTML document");

    let mut url = None;
    let content = match Url::parse(uri.as_str()) {
        Ok(res) => {
            let content = ureq::get(res.as_str())
                .call()?
                .body_mut()
                .read_to_string()?;
            url = Some(res.to_string());
            content
        }
        Err(_) => read_to_string(uri)?,
    };

    let res = Readability::new(
        content,
        url.as_deref(),
        Some(dom_smoothie::Config {
            text_mode,
            ..Default::default()
        }),
    )?
    .parse()?
    .text_content
    .to_string();

    println!("{res}");

    Ok(())
}
