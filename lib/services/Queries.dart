class Queries {

  String refreshToken(String refreshToken){
    return '''
        mutation{
          refreshToken(refreshToken: "$refreshToken"){
            accessToken
            refreshToken
          }
        }

    ''';
  }

  String registerUser(String firstName, String lastName, String email, String password) {
    return """
        mutation {
          signUp(data: {firstName: "$firstName", lastName: "$lastName", email: "$email", password: "$password"}){
            accessToken
            user{
                _id
                firstName
                 joinedOrganizations{
                  _id
                  name
                 }
              }
              refreshToken
            }
        }

    """;
  }

  String loginUser(String email, String password) {
 
    return """
        mutation {
          login(data: {email: "$email", password: "$password"}){
            accessToken
            user{
                _id
                firstName
                 joinedOrganizations{
                  _id
                  name
                 }
              }
              refreshToken
            }
        }

    """;
  }


  String fetchUserInfo = ''' 
       query Users(\$id: ID!){
          users(id:\$id){
          firstName
          lastName
          email
          joinedOrganizations{
            _id
            name
            description
          creator{
          firstName
          lastName
          }
        }
           createdOrganizations {
            _id
            name
          }
          adminFor {
            _id
            name
          }
        }
      }
    ''';

  String fetchUserInfo2(String id) {
    return ''' 
       query {users(id:"$id"){
          firstName
          lastName
          email
          joinedOrganizations{
            _id
            name
          creator{
          firstName
          lastName
          }
        }
           createdOrganizations {
            _id
            name
          }
          adminFor {
            _id
            name
          }
        }
      }
    ''';
  }

  final String fetchOrganizations = '''
    query{
      organizations(){
        _id
        name
        description
        creator{
          firstName
          lastName
        }
        members{
          _id
          firstName
          lastName
          email
        }
      }
    }
  ''';

    String fetchOrgById (String orgId) {
    return '''
    query{
      organizations(id:"$orgId"){
        _id
        name
        description
        creator{
          firstName
          lastName
        }
        members{
          _id
          firstName
          lastName
          email
        }
      }
    }
  ''';
    }

  String getOrgId(String orgId) {
    return '''
    mutation {
      joinPublicOrganization(organizationId: "$orgId") {
          joinedOrganizations{
            _id
            name
          }
      }
	}
  ''';
  }

  String createOrg(String name, String description, String attendees,
      bool isPublic, bool visibleInSearch) {
    return '''
      mutation {
          createOrganization(data: {name: "$name", description: "$description", attendees: "$attendees", isPublic: $isPublic, visibleInSearch: $visibleInSearch}){
            _id
            name
            description
          creator{
            firstName
            lastName
            
          }
        }
    }
  ''';
  }

  String updateOrg(String orgId, String name, String description,
      bool isPublic, bool visibleInSearch) {
    return '''
      mutation {
          updateOrganization(id: "$orgId", data: {name: "$name", description: "$description", isPublic: $isPublic, visibleInSearch: $visibleInSearch}){
            _id
            name
        }
    }
  ''';
  }
//////////////EVENTS/////////////////////
  String fetchEvents() {
    return """
      query {
        events{ 
          _id
          title
          description
          isPublic
          isRegisterable
          recurring
          recurrance
        }
      }
    """;
  }

  String deleteEvent(String id) {
    return """
      mutation {
        removeEvent(
          id: "$id",
          ){
            _id
          }
        }
    """;
  }

  String registerForEvent = """
      mutation RegisterForEvent(
        \$id: ID!,
        )
        {registerForEvent(
          id: \$id,
          ){
            _id
            title
            description
          }
        }
    """;

  final String addEventProject = """
      mutation CreateEventProject(
        \$title: String!,
        \$description: String!,
        \$eventId: String!,
        ){
        createEventProject(
          data:{
            title: \$title,
            description: \$description,
            eventId: \$eventId,
          }){
            _id
            title
            description
          }
        }
    """;

  String addEvent(organizationId, title, description, isPublic, isRegisterable,
      recurring, recurrance, date) {
    return """
      mutation {
        createEvent(
          data:{
           organizationId: "$organizationId",
           title: "$title",
           description: "$description",
           isPublic: $isPublic,
           isRegisterable: $isRegisterable,
           recurring: $recurring,
           recurrance: "$recurrance",

          }){
            _id
            title
            description
          }
        }
    """;
  }

///////////////////NEWSFEED////////////////
  String posts = """
      query {
        posts
        { 
          _id
          text
          createdAt
          imageUrl
          videoUrl
          creator{
            firstName
            lastName
          }
          organization{
            _id
          }
          linkedBy{
            _id
          }
          comments{
            _id
          }
        }
      }
""";

  String addPost(String text, String organizationId) {
    return """
    mutation {
        createPost(
            data: {
                text: "",
                organizationId: "",
        }) {
            _id
            text
        }
    }
  """;
  }
}
