// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

contract RushChapterII {

    struct Sale {
        address seller;
        uint256 price;
        bool isClosed;
        uint256 offerCount;
    }

    struct Offer {
        address buyer;
        uint256 price;
        bool isAccepted;
    }

    uint256 internal salesNbr = 0;
    uint256 internal offerNbr = 0;
    mapping(uint256 => Sale) internal sales;
    mapping(uint256 => Offer) internal offers;
    mapping(uint256 => mapping(uint256 => uint256)) internal saleOffers;
    mapping(uint256 => mapping(uint256 => bool)) internal offerStatus;

    // @description: Create a new sale
    // @param: The params of the sale
    // @return: Id of the sale
    function createSale() public returns(uint256) {
        salesNbr++;
        sales[salesNbr] = Sale(msg.sender, 0, false, 0);
        return salesNbr;
    }

    // @description: Get a sale
    // @param _id: the id of the sale
    // @return: The sale
    function getSale(uint256 _id) public view returns(Sale memory) {
        return sales[_id];
    }

    // @description: Add an offer to a sale
    // @param _saleId: the id of the sale
    // @param _price: the price of the offer
    // @return: Id of the offer
    function addOffer(uint256 _saleId, uint256 _price) public returns(uint256) {
        require(!sales[_saleId].isClosed, "Sale is closed");
        offerNbr++;
        offers[offerNbr] = Offer(msg.sender, _price, false);
        saleOffers[_saleId][sales[_saleId].offerCount] = offerNbr;
        offerStatus[_saleId][offerNbr] = true;
        sales[_saleId].offerCount++;
        return offerNbr;
    }

    // @description: Get an offer
    // @param _id: the id of the offer
    // @return: The offer
    function getOffer(uint256 _id) public view returns(Offer memory) {
        return offers[_id];
    }

    // @description: Accept an offer
    // @param _offerId: the id of the offer
    // @param _isAccepted: true if the offer is accepted, false otherwise
    // @return: Nothing
    function responseToOffer(uint256 _offerId, bool _isAccepted) public {
        require(salesNbr > 0, "No sales available");
        require(offers[_offerId].buyer != address(0), "Invalid offer ID");
        require(!offers[_offerId].isAccepted, "Offer already accepted");

        offers[_offerId].isAccepted = _isAccepted;

        if (_isAccepted) {
            uint256 _saleId = findSaleIdByOfferId(_offerId);
            require(_saleId != 0, "Invalid sale ID");

            Sale storage sale = sales[_saleId];
            require(!sale.isClosed, "Sale is closed");

            sale.isClosed = true;
            sale.price = offers[_offerId].price;
        }
    }

    // @description: Claim an offer
    // @param _offerId: the id of the offer
    // @return: Nothing
    function buyTheSale(uint256 _offerId) public payable {
        require(salesNbr > 0, "No sales available");
        require(offers[_offerId].buyer != address(0), "Invalid offer ID");
        require(offers[_offerId].isAccepted, "Offer not accepted");
        require(msg.value == offers[_offerId].price, "Incorrect amount");

        uint256 _saleId = findSaleIdByOfferId(_offerId);
        require(_saleId != 0, "Invalid sale ID");

        Sale storage sale = sales[_saleId];
        require(sale.isClosed, "Sale not closed");

        address payable seller = payable(sale.seller);
        seller.transfer(msg.value);
    }

    // @description: Close a sale
    // @param _saleId: the id of the sale
    // @return: Nothing
    function getSaleBalance(uint256 _saleId) public {
        require(salesNbr > 0, "No sales available");
        require(_saleId > 0 && _saleId <= salesNbr, "Invalid sale ID");

        Sale storage sale = sales[_saleId];
        require(sale.isClosed, "Sale not closed");

        address payable seller = payable(sale.seller);
        seller.transfer(sale.price);
    }

    // @description: Find the sale ID by offer ID
    // @param _offerId: the id of the offer
    // @return: The sale ID
    function findSaleIdByOfferId(uint256 _offerId) internal view returns (uint256) {
        for (uint256 i = 1; i <= salesNbr; i++) {
            Sale storage sale = sales[i];
            for (uint256 j = 0; j < sale.offerCount; j++) {
                if (saleOffers[i][j] == _offerId && offerStatus[i][_offerId]) {
                    return i;
                }
            }
        }
        return 0;
    }
}
