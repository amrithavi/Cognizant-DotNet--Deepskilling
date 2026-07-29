function BlogDetails(props) {
  const isInstalled = props.showInstall;

  const content = (
    <div>
      <h3>Welcome to Learning React!</h3>
      {isInstalled && (
        <div>
          <h4>React Installation</h4>
          <p>You can install React from npm.</p>
        </div>
      )}
    </div>
  );

  return (
    <div className="v1">
      <h1>Blog Details</h1>
      {content}
    </div>
  );
}

export default BlogDetails;