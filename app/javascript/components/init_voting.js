const initVoting = () => {
  const vote = document.querySelector('vote')
  vote.addEventListener('click', (event) => {
    fetch(window.location.origin + 'vote')
      .then(response => response.json())
      .then((data) => {
        console.log(data);
      })
  })
}

export { initVoting };
