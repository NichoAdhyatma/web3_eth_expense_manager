module.exports = {
  networks: {
    development: {
        host: "192.168.187.59",
        port: 7545,
        network_id: "*",
    }
  },
  contracts_directory: "./contracts",
  compilers: {
    solc: {
      version: "0.8.17",
       optimizer: {
         enabled: false,
         runs: 200
       }
      }
    },
  db: {
    enabled: false
  }
};
