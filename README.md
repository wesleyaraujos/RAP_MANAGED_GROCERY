
https://learning.sap.com/learning-journeys/learn-the-basics-of-abap-programming-on-sap-btp/building-an-abap-restful-application

Building an ABAP RESTful Application
Objectives

After completing this lesson, you will be able to:
Understand the components of an ABAP RESTful Application.
Create the sustainable groceries application.
Understanding RESTful Application Programming Components
The ABAP RESTful Application Programming Model defines the architecture for end-to-end development of OData services (such as SAP Fiori apps) in the ABAP environment. It supports the development of all types of Fiori applications and the publishing of Web APIs. It is based on technologies and frameworks such as Core Data Services (CDS) for defining semantically rich data models and a service model infrastructure for creating OData services with bindings to an OData protocol and ABAP-based application services for custom logic and SAPUI5-based user interfaces.

In this unit, you will create a Sustainable Grocery Application using an ABAP RESTful Application. The required objects for an ABAP RESTful Application include:

Database Tables
Core Data Service (CDS) Entities
Core Data Service (CDS) Behavior Definitions
Core Data Service (CDS) Metadata Extensions
A Service Definition
A Service Binding
Basic architecture of an ABAP RESTful application
Developing a RAP application consists of the following main steps:

Provide the Database Tables
Developing a RESTful Application starts with providing the database tables. Depending on the development scenario, these can be existing tables, legacy tables, or tables created specifically for this application.
Define the Data Model.
The data model of the Business Object is defined with Core Data Service (CDS) Views. Depending on whether it is a simple or a composite Business Object, one or more CDS Views are required. In the case of a composite Business Object, this is also the place where you define the entity hierarchy.
Define and Implement the Behavior (Transactional apps only)
The behavior of a RESTful Application Business Object is defined in a repository object called Core Data Service (CDS) Behavior Definition. Usually, the behavior of a RESTful Application Programming Business Object also requires some additional logic implemented in a certain type of global ABAP class called a Behavior Pool. For a non-transactional application, for example, a list report, the behavior definition or implementation can be omitted.
Project the RESTful Application Programming Business Object and provide service-specific Metadata
The RESTful Application Programming Business Object projection consists of a data model projection and, if a behavior has been defined, a behavior projection. To define a projection, you create one or more Core Data Service (CDS) projection views, which is a type of CDS View, and a Behavior Projection, which is a type of behavior definition. For User Interface (UI) services, the projection view(s) should be enriched with UI-specific metadata. To support the future extensibility of the application, we recommend placing the service-specific annotations in metadata extensions.
Define the Service
In RESTful Applications, a service is defined by creating a Service Definition. The service definition references the projection views and specifies what should be exposed, that is, what is visible to the service consumer.
Bind the Service and Test the Service
A service binding is needed to specify how the service should be consumed (UI or Web API) and via which protocol (OData V2 or OData V4). For UI services, a Preview is available.
Creation of the Sustainable Grocery Application
Graph showing the flow of creating an ABAP RESTful application
To create the RESTful Application Program, the following object needs to be created or generated:

A Database Table
A database table will permanently store the data in the database. We will create a simple database table to store information on your purchased groceries.
Additional Objects
A number of objects required by the RESTful Application Program will be generated through the Generate ABAP Repository Objects... feature of ABAP Development Tools (ADT).
Behavior
The behavior of a RESTful Application Program Business Object is defined in a repository object called a Core Data Service (CDS) Behavior Definition. Usually, the behavior also requires additional logic, which is implemented in a certain type of global ABAP class called a Behavior Pool. For a non-transactional application, for example, a list report, the behavior definition or implementation can be omitted. The behavior we will add is an action to check if the grocery items selected have expired. This will set the expired flag in the database table.
Metadata Extension
The metadata extension file allows customization of the user interface.
Create a Database Table
Database Table for Sustainable Grocery App
A database table is required to store our grocery data. We will create a database table to use in our Sustainable Grocery Application.

Note

In this exercise, XX refers to your number.
Steps
Create a database table named ZXX_GROCERY.

Right-click on your package ZS4D100_XX in the Project Explorer and choose New → Other ABAP Repository Object. Type table in the filter and choose Database Table. Press Next.

Enter ZXX_GROCERY as the name and Groceries as the description. Press Next to continue.

Choose your existing transport request and press Finish.

Adjust the ZXX_GROCERY file by copying the template code and replacing all occurrences of XX with your number.

Replace the generated code in ZXX_GROCERY with the following code:

Code Snippet

Copy code

Switch to dark mode

@EndUserText.label : 'Groceries'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zXX_grocery {

  key client : abap.clnt not null;
  key id : sysuuid_x16 not null;
  product : abap.char(40);
  category : abap.char(40);
  brand : abap.char(40);
  @Semantics.amount.currencyCode : 'zXX_grocery.currency'
  price : abap.curr(10,2);
  currency : abap.cuky;
  quantity : abap.int2;
  purchasedate : abap.dats;
  expirationdate : abap.dats;
  expired : abap_boolean;
  rating : abap.fltp;
  note : abap.char(255);
  createdby : abp_creation_user;
  createdat : tzntstmpl;
  lastchangedby : abp_lastchange_user;
  lastchangedat : abp_lastchange_tstmpl;
  locallastchanged : abp_locinst_lastchange_tstmpl;

}
Copy the code in the exercise by pressing Copy To Clipboard.

In Eclipse select Edit → Select All.

Select Edit → Delete.

Select Edit → Paste.

Select Edit → Find/Replace.

Enter XX in the Find field and your number in the Replace with field.

Press Replace All.

Press Close.

Press Activate (Ctrl-F3).

Practice
Exercise
Start Exercise
Result
You now have a database table to store your grocery information.

Generating Additional Objects
Generating Additional Objects
We have just defined a database table to hold our data, but the app we will create needs more objects than just this table. We can generate these objects using a wizard in ABAP Development Tools (ADT).

Extended architecture of an ABAP RESTful application
The generated objects contain all the information necessary to provide a working app with create, read, update, and delete capabilities. Later on, we will also adjust and extend some of these objects to change the appearance of the user interface and to implement a check for expired groceries.

To start the object generator, right-click the table name in the Project Explorer and choose Generate ABAP Repository Objects. The wizard starts, and you must enter a package to which all of the new objects will be assigned. You then select the generator, for this example, we use the ABAP RESTful Application Programming Model UI Service.

Screenshot of the initial page of the ABAP RESTful application programming model generator window
To start the object generator, right-click the table name in the Project Explorer and choose Generate ABAP Repository Objects.... The wizard starts and you must enter a package to which all of the new objects will be assigned. You then select the generator; for this example, we are using the ABAP RESTful Application Programming Model UI Service.

Screenshot of the Data Model tab in the generator window
In the RESTful Application Programming Model, you do not access database tables directly. Instead, you use a Core Data Service (CDS) view entity to define the data model. At this stage, in the generator, you enter the name of a data definition. Since you are working in the customer namespace, the name must begin with Z or Y.

You also have to enter an alias name used inside the generated application to identify the entity that the data definition represents.

Screenshot of the Behavior tab in the generator window
With the data mode view that you create, you can read data from the database. However, our app should also be able to create, modify, and delete data. In order to make this possible, you must define a behavior definition. This is linked to the data mode view and specifies which of the create, update, and delete actions are allowed.

As well as specifying which of the create, update, and delete actions should be available, the behavior definition can also contain the following kinds of definitions:

Draft enabling
Automatic numbering
Validations: These are checks that are carried out when the user enters data in the app
Determinations: A determination performs a calculation to fill fields in the data record.
The generator creates the behavior definition and switches on automatic numbering for the UUID field. If you need to use validations and determinations, you must add them by hand.

The behavior definition declares which validations and determinations exist. However, they also need an ABAP implementation. The implementations are methods, so you therefore need an implementation class. The naming convention for this class is to use the prefix Z or Y for the customer namespace, followed by BP_R. BP stands for behavior pool and R stands for restricted.

The behavior definition also defines the draft enabling for the entity. Based on the definition of the data model view, the generator creates a corresponding table that will contain the draft data. You therefore need to specify the name of the draft table at this point. The naming convention is that for a basic table Z<table>, the draft table should be called Z<table>_D.

Screenshot of the Service Projection tab in the generator window
The data model and its behavior definition are a reusable implementation of a particular business entity. The next step in the object generation is to specify the name of the service projection. The projection contains a view with precisely the fields required for a particular app, a behavior definition specifying which of the defined behaviors should be available in the app, and a metadata extension. The metadata extension contains Core Data Service (CDS) annotations that define how the UI of the app should look.

The naming convention for the projection layer is ZC_<name>. The projection view, behavior projection, and metadata extension will all have the same name.

Screenshot of the Service Binding tab in the generator window
In order to expose the app, you need to create a service definition and a service binding. the service definition specifies the projection view to be exposed in this service, the service binding specifies the protocol to be used. In our example define an OData UI service based on version 4 of the OData protocol.

The naming convention for the service definition is Z<name>. The naming convention for the service binding is ZUI_<name>_O4. This indicates that the binding is for a Fiori Elements app and that it uses version 4 of the OData protocol.

Screenshot of the Preview Generator Output page in the generator window
At the end of the wizard, the system displays a list of all the objects it will generate. You can check your entries against the naming conventions, look out for typing errors, and, if necessary, go back and change any that are incorrect.

Generate Additional Objects
Generate Additional Objects
We need to generate the additional objects needed for the RESTful Application Program Sustainable Grocery App.

Note

In this exercise XX refers to your number.
Steps
Generate the additional objects for the RESTful Application Program Sustainable Grocery App.

In the Project Explorer right-click on your database table ZXX_GROCERY and choose Generate ABAP Repository Objects....

Choose ABAP RESTful Application Programming Model → OData UI Service. Press Next.

Enter your package name (ZS4D100_XX) and Press Next.

Select Business Object → Data Model. Check Data Definition Name is ZR_XX_GROCERY and enter the CDS Alias Name: Grocery.

Select Business Object → Behavior and check the default generated names for the Implementation Class is ZBP_R_XX_GROCERY and Draft Table Name is ZXX_GROCERY_D.

Select Service Projection and check the default name is ZC_XX_GROCERY.

Select Business Service → Service Definition. Check the default name is ZUI_XX_GROCERY_O4.

Select Business Service → Service Binding. Check the default name is ZUI_XX_GROCERY_O4 and the binding type is OData V4 - UI.

Press Next.

View the Preview Generator Output and press Finish to generate the objects.

Practice
Exercise
Start Exercise
Modifying Generated Objects
Several objects need to be modified to customize our application

Screenshot of a Projection View with annotations
In the data definition file, ZC_XX_GROCERY annotations can be added to enable the search capabilities of the application. Annotations begin with an @ symbol. Here, we are adding annotations to allow the search capabilities of specific fields in the application. The annotation is placed before the field name.

Screenshot of a Behavior Definition
In the Behavior Definition ZR_XX_GROCERY, the fields CreatedBy and CreatedAt will be read-only. We are also creating an instance action CheckExpirationDate.

Screenshot of the code completion popup suggesting a fix for a code warning
In the Behavior Definition ZR_XX_GROCERY, you can have Eclipse generate the method checkExpirationDate by clicking on the warning in the margin of the action statement. You then double-click on the Add method ... statement to have the method generated in the local classes of the implementation class ZBP_R_XX_GROCERY.

Screenshot of a Behavior Projection
In the behavior definition ZR_XX_GROCERY , the use action checkExpirationDate; is added to enable the action. .

Screenshot of a Behavior Implementation class
In the implementation class ZBP_R_XX_GROCERY under the tab Local Types will be the method for the action checkExpirationDate. Here, code is needed to check the expirationDate of a selected grocery item and set the flag expired to true or false. The required code is contained in the exercise.

Screenshot of a Metadata Extension
The metadata extension allows for the adjustment of the user interface. @UI.lineItem refers to the initial list, while @UI.identification refers to the detail list on a second screen. In this example, the ID is hidden from the application display. The position is left to right from low to high values. Importance: #HIGH indicates the field should be displayed on all device sizes, while importance: #MEDIUM has the field listed on large (desktop) screens and medium (tablet) screens but not on small (smartphone) screens.

Screenshot of an unpublished Service Binding with the “Publish” button
To publish the service, open the service binding ZUI_XX_GROCERY_O4, select the service, and press the Publish button.

Screenshot of a published Service Binding with the enabled “Preview…” button
To test the application, choose Grocery under Entity Set and Association of the service binding ZUI_XX_GROCERY_04. Press Preview... to launch the application.

Screenshot of the preview of the application
Once in the Sustainable Grocery App, you can press Go to populate the grocery list from existing data. You can also use the Search field to search for grocery items. Press Create to add a new grocery item. Press Delete to remove a grocery item. Select items with a check box and press Check for expiration to check the Expiration Date and set the Expired flag.

If you click on a grocery item, you will be taken to a detail page for that item. From the detail page, you can press Edit to change the item values, press Delete to remove the item, and press Check for expiration to set the expired flag.

Enable Search Capabilities
Enable Search Capabilities of Sustainable Grocery App
You need to turn on the search capabilities of the Sustainable Grocery App. The search capabilities are enabled in the Data Definition file ZC_XX_GROCERY.

Note

In this exercise, XX refers to your number.
Objects to adjust:

Object Type	Object Name	Description of Change
Data Definition	ZC_XX_GROCERY	Enable search capabilities
Steps
Enable the search capabilities in the Data Definition file ZC_XX_GROCERY for fields Product, Category, Brand, ExpirationDate, Expired , and Rating. Replace the code in the data definition file by copying and pasting the solution code below.

Double-click on the data definition file ZC_XX_GROCERY in the Project Explorer to open the file.

Replace the code in the data definition file by copying the following code:

Code Snippet

Copy code

Switch to dark mode
@AccessControl.authorizationCheck: #CHECK
 @Metadata.allowExtensions: true
 @Search: { searchable: true }
 @EndUserText.label: 'Projection View for ZR_XX_GROCERY'
 define root view entity ZC_XX_GROCERY
  provider contract transactional_query
  as projection on ZR_XX_GROCERY
{
    key ID,
    @Search.defaultSearchElement: true
    Product,
    @Search.defaultSearchElement: true
    Category,
    @Search.defaultSearchElement: true
    Brand,
    Price,
    Currency,
    Quantity,
    PurchaseDate,
    @Search.defaultSearchElement: true    
    ExpirationDate,
    @Search.defaultSearchElement: true
    Expired,
    @Search.defaultSearchElement: true
    Rating,
    Note,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LocalLastChanged
}
In the data definition file ZC_XX_GROCERY, press Ctrl-A to select all the contents and then press the Delete key. Press Ctrl-V → to paste the contents previously copied.

Press Ctrl-F. Enter XX in the Find field and your number in the Replace with field. Press Replace All. Press Close.

Press Activate (Ctrl+F3).

Practice
Exercise
Start Exercise
Result
The fields Product, Category, Brand, ExpirationDate, and Rating are now search enabled.

Modify Behavior
Modify Behavior of Sustainable Grocery App
The behavior of the Sustainable Grocery App needs to be modified. Some fields should be read-only and an action needs to be added to check the product's expiration date.

Note

In this exercise, XX refers to your number.
Objects to adjust:

Object Type	Object Name	Description of Change
Behavior Definition	ZR_XX_GROCERY	Specify, any read-only fields, create an action to check item expiration and generate the action method
Behavior Definition	ZC_XX_GROCERY	Enable action to check expiration date
Steps
In the behavior definition file ZR_XX_GROCERY create the action checkExpirationDate and make fields CreatedBy, and CreatedAt read-only.

Double-click on the behavior definition file ZR_XX_GROCERY in the Project Explorer to open the file.

Replace the code in the behavior definition file by copying the following code:

Code Snippet

Copy code

Switch to dark mode

managed implementation in class ZBP_R_XX_GROCERY unique;
strict ( 2 );
with draft;

define behavior for ZR_XX_GROCERY alias Grocery
persistent table zXX_grocery
draft table ZXX_GROCERY_D
etag master LocalLastChanged
lock master total etag LastChangeDat
authorization master( global )

{
  field ( readonly )
  ID,
 

  field ( numbering : managed )
  ID;

  create;
  update;
  delete;

  draft action Edit;
  draft action Activate optimized;
  draft action Discard;
  draft action Resume;
  draft determine action Prepare;

  

  mapping for ZXX_GROCERY
  {
    ID = id;
    Product = product;
    Category = category;
    Brand = brand;
    Price = price;
    Currency = currency;
    Quantity = quantity;
    PurchaseDate = purchasedate;
    ExpirationDate = expirationdate;
    Expired = expired;
    Rating = rating;
    Note = note;
    CreatedBy = createdby;
    CreatedAt = createdat;
    LastChangedBy = lastchangedby;
    LastChangeDat = lastchangedat;
    LocalLastChanged = locallastchanged;
  }
}
In the behavior definition file ZR_XX_GROCERY, press Ctrl-A to select all the contents and then press the Delete key. Press Ctrl-V to paste the contents previously copied.

Press Ctrl-F. Enter XX in the Find field and your number in the Replace with field. Press Replace All. Press Close.

Press Activate (Ctrl+F3).

Generate the action method checkExpirationDate.

In the behavior definition file ZR_XX_GROCERY, find the line that defines the action checkExpiratonDate. It will have a warning that the implementation is missing. Click on the warning in the margin to see a pop-up that states: Add method for action checkExpirationDate.... Double-click this line to generate the method in the implementation class ZBP_R_XX_GROCERY.

The implementation class ZBP_R_XX_GROCERY will open in the editor. Press Activate (Ctrl-F3).

To enable the action, add a use action checkExpirationDate; statement to behavior definition file ZC_XX_GROCERY.

Double-click on the behavior definition file ZC_XX_GROCERY in the Project Explorer to open the file.

Replace the code in the behavior definition file by copying the following code:

Code Snippet

Copy code

Switch to dark mode
projection;
strict ( 2 );
use draft;

define behavior for ZC_XX_GROCERY alias Grocery
use etag

{
    use create;
    use update;
    use delete;

    use action Edit;
    use action Activate;
    use action Discard;
    use action Resume;
    use action Prepare;

    
}
In the behavior definition file ZR_XX_GROCERY, press Ctrl-A to select all the contents and then press the Delete key. Press Ctrl-V to paste the contents previously copied.

Press Ctrl-F. Enter XX in the Find field and your number in the Replace with field. Press Replace All. Press Close.

Press Activate (Ctrl+F3).

Practice
Exercise
Start Exercise
Result
The fields Createdby, CreatedAt, LastChangeDat, and LocalLastChanged are now read-only. The action checkExpirationDate has been declared.

Check Product Expiration
Implement ABAP Code for Check Product Expiration Date
In the Sustainable Grocery App an action has been defined to check the expiration date of a product. You need to add ABAP code to check the expiration date and if the expiration date is in the past, the flag Expired needs to be set.

Note

In this exercise, XX refers to your number.
Objects to adjust:

Object Type	Object Name	Description of Change
Implementation Class	ZBP_R_XX_GROCERY	Add action code to check for selected item expiration
Steps
Implement the local method checkExpirationDate in the implementation class ZBP_R_XX_GROCERY.

Double-click on the class file ZBP_R_XX_GROCERY in the Project Explorer to open the file.

Click on the Local Types tab bottom of the editor window.

Replace the code in the behavior definition file by copying the following code:

Code Snippet

Copy code

Switch to dark mode
CLASS lhc_grocery DEFINITION INHERITING FROM cl_abap_behavior_handler.
    PRIVATE SECTION.
      METHODS:
        get_global_authorizations FOR GLOBAL AUTHORIZATION
            IMPORTING
            REQUEST requested_authorizations FOR Grocery
            RESULT result,
        checkExpirationDate FOR MODIFY
            IMPORTING keys FOR ACTION Grocery~checkExpirationDate RESULT result.
ENDCLASS.

CLASS lhc_grocery IMPLEMENTATION.

METHOD get_global_authorizations.
ENDMETHOD.

METHOD checkExpirationDate.

    DATA: lt_groceries TYPE TABLE FOR READ RESULT zr_xx_grocery,
          ls_grocery TYPE STRUCTURE FOR READ RESULT zr_xx_grocery,
          lv_expiration TYPE d,
          lv_current_date TYPE d,
          lv_expired TYPE abap_boolean,
          lt_update_groceries TYPE TABLE FOR UPDATE zr_xx_grocery.

    READ ENTITIES OF zr_xx_grocery
      IN LOCAL MODE ENTITY Grocery
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT lt_groceries.

    LOOP AT lt_groceries INTO ls_grocery.
      lv_expiration = ls_grocery-Expirationdate.
      lv_current_date = cl_abap_context_info=>get_system_date( ).
      IF lv_expiration < lv_current_date.
        lv_expired = abap_true.
      ELSE.
        lv_expired = abap_false.
      ENDIF.

    APPEND VALUE #( id = ls_grocery-Id expired = lv_expired )
      TO lt_update_groceries.
    MODIFY ENTITIES OF zr_xx_grocery IN LOCAL MODE
      ENTITY Grocery
      UPDATE FIELDS ( expired )
      WITH lt_update_groceries.
    ENDLOOP.

    result = VALUE #( FOR groceries IN lt_groceries
      ( id = groceries-id %param = groceries ) ).
ENDMETHOD.
ENDCLASS.
In the class file ZBP_XX_GROCERY, press Ctrl-A to select all the contents and then press the Delete key. Press Ctrl-V to paste the contents previously copied.

Press Ctrl-F. Enter XX in the Find field and your number in the Replace with field. Press Replace All. Press Close.

Press Activate (Ctrl+F3).

Practice
Exercise
Start Exercise
Result
The ABAP code to check the expirationDate and set the expired field has been implemented.

Enhance User Interface
Customize the User Interface of the Sustainable Grocery App
The user interface of the Sustainable Grocery App needs to be customized to specify which data to display and in what way.

Note

In this exercise, XX refers to your number.
Objects to adjust:

Object Type	Object Name	Description of Change
Metadata Extension	ZC_XX_GROCERY	Specify user interface information such as which data to display, how to display the data and enable the action functionality
Steps
Customize the user interface (UI) by adding @UI annotations to the metadata extension file ZC_XX_GROCERY. @UI.lineITem refers to the initial list, while @UI.identification refers to the detail list on a second screen. The annotations are placed before the field name. Here are some sample @UI commands:

@UI.hidden: true
Hides the field from display
@UI.lineItem.position
Order the fields from left to right with lower numbers to the right and higher numbers to the left
@UI.lineItem.importance
Which devices should display item:
#HIGH - all screen sizes (desktops, tablets, and smartphones)
#MEDIUM - large (desktops) and medium (tablet) screens
#LOW - large screens (Desktops)
@UI.lineItem.label
Label of field
Double-click on the metadata extension file ZC_XX_GROCERY in the Project Explorer to open the file.

Replace the code in the behavior definition file by copying the following code:

Code Snippet

Copy code

Switch to dark mode
@Metadata.layer: #CORE
@UI: {
    headerInfo: {
    typeName: 'Sustainable Grocery App',
    typeNamePlural: 'Sustainable Groceries App'
  }
}
annotate view ZC_XX_GROCERY with
{
  @UI.facet: [ {
    id: 'idIdentification',
    type: #IDENTIFICATION_REFERENCE,
    label: 'Sustainable Groceries App',
    position: 10
  } ]
  @UI: { lineItem: [ { exclude: true } ,
  { type: #FOR_ACTION,
    dataAction: 'checkExpirationDate' ,
    label: 'Check for expiration' } ] ,
identification: [ { position: 1, label: 'ID' } ,
  { type: #FOR_ACTION,
    dataAction: 'checkExpirationDate',
    label: 'Check for expiration' } ] }

    @UI.hidden: true
    ID;

    @UI.lineItem: [ {
      position: 10 ,
      importance: #HIGH,
      label: 'Product'
    } ]
    @UI.identification: [ {
      position: 10 ,
      label: 'Product'
    } ]
    Product;

    @UI.lineItem: [ {
      position: 20 ,
      importance: #MEDIUM,
      label: 'Category'
    } ]
    @UI.identification: [ {
      position: 20 ,
      label: 'Category'
    } ]
    Category;

    @UI.lineItem: [ {
      position: 30 ,
      importance: #MEDIUM,
      label: 'Brand'
    } ]
    @UI.identification: [ {
      position: 30 ,
      label: 'Brand'
    } ]
    Brand;

    @UI.lineItem: [ {
      position: 40 ,
      importance: #MEDIUM,
      label: 'Price/Currency'
    } ]
    @UI.identification: [ {
      position: 40 ,
      label: 'Price/Currency'
    } ]
    Price;

    @UI.hidden: true
    Currency;

    @UI.lineItem: [ {
      position: 60 ,
      importance: #MEDIUM,
      label: 'Quantity'
    } ]
    @UI.identification: [ {
      position: 60 ,
      label: 'Quantity'
    } ]
    Quantity;

    @UI.lineItem: [ {
      position: 70 ,
      importance: #MEDIUM,
      label: 'Purchase Date'
    } ]
    @UI.identification: [ {
      position: 70 ,
      label: 'Purchase Date'
    } ]
    PurchaseDate;

    @UI.lineItem: [ {
      position: 80 ,
      importance: #MEDIUM,
      label: 'Expiration Date'
    } ]
    @UI.identification: [ {
      position: 80 ,
      label: 'Expiration Date'
    } ]
    ExpirationDate;

    @UI.lineItem: [ {
      position: 90 ,
      importance: #MEDIUM,
      label: 'Expired'
    } ]
    @UI.identification: [ {
    position: 90,
    label: 'Expired'
    } ]
    Expired;

    @UI.lineItem: [ {
      position: 100 ,
      importance: #MEDIUM,
      label: 'Rating'
    } ]
    @UI.identification: [ {
      position: 100 ,
      label: 'Rating'
    } ]
    Rating;

    @UI.lineItem: [ {
      position: 110 ,
      importance: #MEDIUM,
      label: 'Note'
    } ]
    @UI.identification: [ {
      position: 110 ,
      label: 'Note'
    } ]
    Note;

    @UI.hidden: true
    CreatedBy;
  
    @UI.hidden: true
    CreatedAt;

    @UI.hidden: true
    LastChangedBy;

    @UI.hidden: true
    LocalLastChanged;
}
In the metadata extension file ZC_XX_GROCERY, press Ctrl-A to select all the contents and then press the Delete key. Press Ctrl-V to paste the contents previously copied.

Press Ctrl-F. Enter XX in the Find field and your number in the Replace with field. Press Replace All. Press Close.

Press Activate (Ctrl+F3).

Practice
Exercise
Start Exercise
Result
Which fields to display and in which order as well as what to display on the detail page has been defined for the Sustainable Grocery App.

Publish the Sustainable Grocery App
Publish the Sustainable Grocery App
It is time to publish the Sustainable Grocery App.

Note

In this exercise, XX refers to your number.
Objects to adjust:

Object Type	Object Name	Description of Change
Service Binding	ZUI_XX_GROCERY_04	Publish service and test application.
Steps
Publish and test the service.

Double-click on the service bindings file ZUI_XX_GROCERY_04 in the Project Explorer to open the file.

Expand the service ZUI_XX_GROCERY_04 in the services table and select the line below with Version entry 1.0.0. Press the Publish button. The publishing will take a few minutes.

Practice
Exercise
Start Exercise
Result
The Sustainable Grocery App has been published.

Test the Sustainable Grocery App
Test the Sustainable Grocery App
It is time to test the Sustainable Grocery App.

Note

In this exercise, XX refers to your number.
Objects to adjust:

Object Type	Object Name	Description of Change
Service Binding	ZUI_XX_GROCERY_04	Test application.
Steps
Preview the Sustainable Grocery App service.

Double-click on the service bindings file ZUI_XX_GROCERY_04 in the Project Explorer to open the file.

In the Service Version Details section, select Grocery in the Entity Set and Association list.

Press Preview... to launch the application.

Create a new product entry

Choose Create in the application.

Enter product Details:

Product	Oatmeal
Category	Breakfast
Brand	Organics
Price	5.00
Currency	USD
Quantity	1
Purchase Date	Choose 3 weeks ago from today
Expiration Date	Choose 3 days from today
Expired	Unchecked
Rating	5
Note	Yummy
Press Create.

Press the Alt+Left arrow to go back to the previous screen.

Press GO to view your new product.

Check expiration processing.

Select the check box to the right of your product.

Press Check for Expiration. Note field Expired with a value of No.

Click on the product line to go to the detail page.

Choose Edit to change the product.

Change the Expiration Date to 1 day ago.

Press Save.

Press Check for expiration. Notice fields Expired now with a value of Yes.

Press the Alt+Left arrow to go back to the first page.
