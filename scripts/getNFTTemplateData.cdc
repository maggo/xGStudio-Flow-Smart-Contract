import XGStudio from "../contracts/XGStudio.cdc"

pub fun main(address: Address) : {UInt64: AnyStruct}{
    let account1 = getAccount(address)
    let acct1Capability =  account1.getCapability(XGStudio.CollectionPublicPath)
                            .borrow<&{XGStudio.XGStudioCollectionPublic}>()
                            ??panic("could not borrow receiver reference ")

    var nftIds =   acct1Capability.getIDs()

    var dict : {UInt64: AnyStruct} = {}

    for nftId in nftIds {
        var nftData = XGStudio.getNFTDataById(nftId: nftId)
        var templateData =  XGStudio.getTemplateById(templateId: nftData.templateID)

        var nftMetaData : {String:AnyStruct} = {}
        var nftImmutableData = nftData.getImmutableData()

        nftMetaData["templateData"] = templateData;
        nftMetaData["nftImmutableData"] =nftImmutableData;
        
        dict.insert(key: nftId,nftMetaData)
    }
    return dict
}