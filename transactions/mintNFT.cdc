import XGStudio from 0xd9575c84a88eada0

transaction(templateId: UInt64, account:Address){

    prepare(acct: AuthAccount) {
        let actorResource = acct.getCapability
        <&{XGStudio.NFTMethodsCapability}>
        (XGStudio.NFTMethodsCapabilityPrivatePath)
        .borrow() ?? 
        panic("could not borrow a reference to the NFTMethodsCapability interface")
        let immutableData : {String: AnyStruct} = {
            "name" : "Nasir"  
        }
        actorResource.mintNFT(templateId: templateId, account: account, immutableData:immutableData) 
    }
    execute{
        log("nft minted")
    }
}
