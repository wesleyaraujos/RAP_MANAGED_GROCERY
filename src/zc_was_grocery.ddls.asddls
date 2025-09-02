@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZWAS_GROCERY'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_WAS_GROCERY
  provider contract transactional_query
  as projection on ZR_WAS_GROCERY
  association [1..1] to ZR_WAS_GROCERY as _BaseEntity on $projection.ID = _BaseEntity.ID
{
  key ID,
  
  @Search.defaultSearchElement: true
  Product,
  
  @Search.defaultSearchElement: true
  Category,
  
  @Search.defaultSearchElement: true
  Brand,
  
  @Semantics: {
    amount.currencyCode: 'Currency'
  }
  Price,
  @Consumption: {
    valueHelpDefinition: [ {
      entity.element: 'Currency', 
      entity.name: 'I_CurrencyStdVH', 
      useForValidation: true
    } ]
  }
  Currency,
  Quantity,
  Purchasedate,
  Expirationdate,
  Expired,
  Rating,
  Note,
  @Semantics: {
    user.createdBy: true
  }
  Createdby,
  Createdat,
  @Semantics: {
    user.lastChangedBy: true
  }
  Lastchangedby,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  Lastchangedat,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  Locallastchanged,
  _BaseEntity
}
