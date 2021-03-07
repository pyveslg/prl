const initVoting = () => {
  const votes = document.querySelectorAll('.vote');
  votes.forEach((vote) => {
    vote.addEventListener('click', (event) => {
    const commitId = event.currentTarget.dataset.commit_id;
    const voteValue = event.currentTarget.dataset.value;
    console.log(window.location.origin + '/vote' + `?commit_id=${commitId}&vote=${voteValue}`)
    fetch(window.location.origin + '/vote' + `?commit_id=${commitId}&vote=${voteValue}`)
      .then(response => response.json())
      .then((data) => {
        console.log(data);
        const voteCount = document.querySelector(`#commit-${commitId}`)
        voteCount.innerText = data
      })
    })
  })
}

export { initVoting };
