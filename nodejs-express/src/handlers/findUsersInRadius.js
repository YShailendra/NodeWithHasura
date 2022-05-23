const fetch = require("node-fetch")

const HASURA_OPERATION = `
query findUsers($radius:Int){
  findusers(args: {lat: "28.7041", lng: "77.1025", radius: $radius}) {
    id
    first_name
    last_name
    gender
    lat
    lng
  }
}
`;

// execute the parent operation in Hasura
const execute = async (variables) => {
  const fetchResponse = await fetch(
    "http://localhost:8080/v1/graphql",
    {
      method: 'POST',
      body: JSON.stringify({
        query: HASURA_OPERATION,
        variables
      })
    }
  );
  const data = await fetchResponse.json();
  console.log('DEBUG: ', data);
  return data;
};
  

// Request Handler
const findUserHandler = async (req, res) => {

  // get request input
  const { radius } = req.body.input;

  // run some business logic

  // execute the Hasura operation
  const { data, errors } = await execute({ radius });

  // if Hasura operation errors, then throw error
  if (errors) {
    return res.status(400).json(errors[0])
  }

  // success
  return res.json([
    ...data.findusers
  ])

};

module.exports = findUserHandler;