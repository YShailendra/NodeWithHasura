const fetch = require("node-fetch");
const HASURA_OPERATION = `
query findUsersByPage($pageSize:Int,$page:Int) {
  user(limit: $pageSize, offset: $page) {
    id
    first_name
    last_name
    gender
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
const getUserhandler = async (req, res) => {

  // get request input
  let { pageSize, page } = req.body.input;
 
  if(page<=0) page = 1;
  page  = (page-1)*pageSize;

  // run some business logic

  // execute the Hasura operation
  const { data, errors } = await execute({ pageSize, page });

  // if Hasura operation errors, then throw error
  if (errors) {
    return res.status(400).json(errors[0])
  }

  // success
  return res.json([
    ...data.user
  ])

};

module.exports = getUserhandler;