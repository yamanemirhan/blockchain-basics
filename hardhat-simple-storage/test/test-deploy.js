const { ethers } = require("hardhat");
const { expect, assert } = require("chai");

describe("SimpleStorage", function () {
  let simpleStorageFactory, simpleStorage;

  beforeEach(async function () {
    simpleStorageFactory = await ethers.getContractFactory("SimpleStorage");
    simpleStorage = await simpleStorageFactory.deploy();
  });

  it("Should start with a favorite number of 0", async function () {
    const expectedValue = "0";
    const currentValue = await simpleStorage.retrieve();
    assert.equal(currentValue.toString(), expectedValue);
  });

  it("Should update when we call store", async function () {
    const expectedValue = "12";
    const transactionResponse = await simpleStorage.store(expectedValue);
    await transactionResponse.wait(1);
    const currentValue = await simpleStorage.retrieve();
    expect(currentValue.toString()).to.equal(expectedValue);
  });

  it("Should assign fav number to name", async function () {
    const favNumber = "22";
    const name = "Emirhan";
    const transactionResponse = await simpleStorage.addPerson(name, favNumber);
    await transactionResponse.wait(1);
    const getFavNumber = await simpleStorage.nameToFavoriteNumber(name);
    expect(favNumber).to.equal(getFavNumber.toString());
  });
});
