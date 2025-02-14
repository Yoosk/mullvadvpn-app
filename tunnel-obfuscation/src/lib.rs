use async_trait::async_trait;
use std::net::SocketAddr;

mod udp2tcp;
pub use udp2tcp::Udp2TcpSettings;

pub type Result<T> = std::result::Result<T, Error>;

#[derive(err_derive::Error, Debug)]
#[error(no_from)]
pub enum Error {
    #[error(display = "Failed to create Udp2Tcp obfuscator")]
    CreateUdp2TcpObfuscator(#[error(source)] udp2tcp::Error),

    #[error(display = "Failed to run Udp2Tcp obfuscator")]
    RunUdp2TcpObfuscator(#[error(source)] udp2tcp::Error),
}

#[async_trait]
pub trait Obfuscator: Send {
    fn endpoint(&self) -> SocketAddr;
    async fn run(self: Box<Self>) -> Result<()>;
}

pub enum Settings {
    Udp2Tcp(Udp2TcpSettings),
}

pub async fn create_obfuscator(settings: &Settings) -> Result<Box<dyn Obfuscator>> {
    match settings {
        Settings::Udp2Tcp(s) => udp2tcp::create_obfuscator(s)
            .await
            .map_err(Error::CreateUdp2TcpObfuscator),
    }
}
