/* Google Forms Discord Logs */
/* Made by ByCoquito1#0001 /*
const webhooks = [ "YOUR-WEBHOOK-URL" ];

/* Start of optional section */
const title = "EMBED-TITLE"; /*    Add a nice custom title, to make the script truly yours.    */
const avatarImage = "AVATAR-IMAGE"; /*    The logo of your brand or Discord server, maybe?    */
const shortDescription = "SHORT-DESCRIPTION"; /*    A little bit of information about the response received, so you don't forget in the future?    */
const colour = "EMBED-COLOR"; /*    A custom colour? Example: #78A8C6, RED, AQUA, etc    */
const mention = "MENTION"; /*Mention yourself or a role - it should look like <@1072256782765928549> or <@&1072256782765928549>    */
/* End of optional section */


const form = FormApp.getActiveForm();
const allResponses = form.getResponses();
const latestResponse = allResponses[ allResponses.length - 1 ];
const response = latestResponse.getItemResponses();
var items = [];

if(!webhooks ) throw "You forgot the webhook :)";

function embedText( e ) {
    for ( var i = 0; i < response.length; i++ ) {
        const question = response[ i ].getItem().getTitle();
        const answer = response[ i ].getResponse();
        if ( answer == "" ) continue;
        items.push( { "name": question, "value": answer } );
        function data( item ) { return [ `**${ item.name }**`,`${ item.value }` ].join( "\n" ); }
    }

    try {
      if(avatarImage !== null ) {
          const embedSetup = { "method": "post", "headers": { "Content-Type": "application/json" }, muteHttpExceptions: true, "payload": JSON.stringify( { "content": ( mention ) ? `${ mention }` : " ", "embeds": [ { "title": ( title ) ? title : form.getTitle(), "thumbnail": { "url": encodeURI( avatarImage ) }, "color": ( colour ) ? parseInt(colour.substr(1), 16) : Math.floor( Math.random() * 16777215 ), "description": ( shortDescription ) ? `${ shortDescription }\n\n${ items.map( data ).join( '\n\n' ) }` : items.map( data ).join( '\n\n' ), "timestamp": new Date().toISOString(), } ] } ) };
          for ( var i = 0; i < webhooks.length; i++ ) { UrlFetchApp.fetch( webhooks[ i ], embedSetup ); }
          return form.deleteResponse( latestResponse.getId() );
      }else{
          const embedSetup = { "method": "post", "headers": { "Content-Type": "application/json" }, muteHttpExceptions: true, "payload": JSON.stringify( { "content": ( mention ) ? `${ mention }` : " ", "embeds": [ { "title": ( title ) ? title : form.getTitle(), "color": ( colour ) ? parseInt(colour.substr(1), 16) : Math.floor( Math.random() * 16777215 ), "description": ( shortDescription ) ? `${ shortDescription }\n\n${ items.map( data ).join( '\n\n' ) }` : items.map( data ).join( '\n\n' ), "timestamp": new Date().toISOString(), } ] } ) };
          for ( var i = 0; i < webhooks.length; i++ ) { UrlFetchApp.fetch( webhooks[ i ], embedSetup ); }
          return form.deleteResponse( latestResponse.getId() );
      }
    } catch(error) {
      return Logger.log(error);
    }
}