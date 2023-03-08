
// eslint-disable-next-line no-unused-vars
const tokens = (n) => {
  // eslint-disable-next-line no-undef
  return ethers.utils.parseUnits(n.toString(), 'ether')
}

describe("Dappazon", () => {
    let dappazon;

    beforeEach( async () => {
      // Deploy the contract
      const dappazon = await ethers.getContractFactory("Dappazon");
      // eslint-disable-next-line no-const-assign
      dappazon = await Dappazon.deploy();

    })  
})
