#[tokio::main]
async fn main() {
    println!("NeoPanel Daemon started");
    loop {
        tokio::time::sleep(std::time::Duration::from_secs(5)).await;
    }
}