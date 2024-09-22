module ckmt::NFTDiploma {

    use std::signer;
    use std::string;

    // Struct to hold diploma details
    struct Diploma has key {
        title: string::String,
        issued_by: address,
        issued_to: address,
    }

    // Struct for viewing diploma details safely
    struct DiplomaView has copy, drop {
        title: string::String,
        issued_by: address,
        issued_to: address,
    }

    // Function to issue an NFT diploma
    public entry fun issue_nft_diploma(issuer: &signer, student: address, title: string::String) {
        let diploma = Diploma {
            title,
            issued_by: signer::address_of(issuer),
            issued_to: student,
        };
        move_to(issuer, diploma);
    }

    // Function to view the NFT diploma details
    public fun view_nft_diploma(student: address): DiplomaView acquires Diploma {
        let diploma = borrow_global<Diploma>(student);
        // Return a copy of the diploma details in a new struct
        DiplomaView {
            title: diploma.title,
            issued_by: diploma.issued_by,
            issued_to: diploma.issued_to,
        }
    }
}
