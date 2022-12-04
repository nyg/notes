# Apollo GraphQL

* Website: [https://www.apollographql.com/](https://www.apollographql.com/)
* Apollo Client docs: [https://www.apollographql.com/docs/react/](https://www.apollographql.com/docs/react/)
* Example: [https://github.com/nyg/dependabot-vuln-viewer](https://github.com/nyg/dependabot-vuln-viewer)

### GraphQL Server

A GraphQL server usually defines only one endpoint (e.g. `/queries`) through which are handled different Query Types.

### Apollo Type Policy

A Type Policy defines how the Apollo cache interacts with each GraphQL query type.

### Apollo Field Policy

Each type policy allows a Field Policy to be defined. A field policy defines how a particular field (of a query type) is read from and written to the Apollo cache.

### Simplified Overview

![](../assets/apollo-graphql.svg)
