const initVoting = () => {
  const votes = document.querySelectorAll('.vote');
  votes.forEach((vote) => {
    vote.addEventListener('click', (event) => {
      const commitId = event.currentTarget.dataset.commitId;
      const voteValue = event.currentTarget.dataset.value;

      fetch(`/vote?commit_id=${commitId}&vote=${voteValue}`)
        .then(response => response.json())
        .then(data => {
          const voteCount = document.querySelector(`#commit-${commitId}`);
          voteCount.innerText = data;
        });
    })
  })
}

export { initVoting };
