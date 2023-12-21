
document.addEventListener('DOMContentLoaded', function () {
    const leftWrapContainer = document.getElementById('left-wrap');
    const rightWrapContainer = document.getElementById('right-wrap');
    const recipeSearchResults = document.getElementById('search-results');
    const newSearch = document.getElementById('searchBtn');

    // Spoonacular API key
    const spoonacularAPIKey = gon.env_variables.SPOONACULAR_API_KEY;

    const modal = document.getElementById("myModal");
    const modalBody = document.getElementById('modal-body');

    newSearch.addEventListener("click", getRecipeNames);

    function getRecipeNames(event) {
        event.preventDefault();
        recipeSearchResults.innerHTML = '';

        const ingredients = document.querySelectorAll('.ingredient-input');
        const allIngreds = Array.from(ingredients).map(input => input.value).join(',');

        const newRecipe = `https://api.spoonacular.com/recipes/findByIngredients?ingredients=${allIngreds}&number=10&apiKey=${spoonacularAPIKey}`;

        fetch(newRecipe)
            .then(response => {
                if (!response.ok) {
                    const errorStatus = response.status;
                    console.log(errorStatus);
                    throw Error("ERROR");
                }
                return response.json();
            })
            .then(data => {
                if (data.length === 0) {
                    modal.style.display = "block";
                } else {
                    modal.style.display = "none";
                }
                showSearchResults(data);
            })
            .catch(error => {
                console.error('Error:', error);
            });

        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        };

        ingredients.forEach(input => {
            input.value = '';
        });
    }

    function showSearchResults(data) {
        rightWrapContainer.style.display = "block";
        recipeSearchResults.style.display = "block";

        for (let i = 0; i < data.length; i++) {
            const recipe = data[i].title;
            const recipeImage = data[i].image;
            const recipeId = data[i].id;

            const li = document.createElement('li');

            li.innerHTML = `
                <div class="card mb-3 searchResult">
                    <div class="row no-gutters">
                        <img src="${recipeImage}" class="card-img col-md-4 recipe-image" alt="Photo of recipe">
                        <div class="card-body col-md-8 pl-4 my-auto">
                            <h2 class="card-title">${recipe}</h2>
                        </div>
                    </div>
                </div>
            `;

            recipeSearchResults.appendChild(li);

            const recipeImageElement = li.querySelector('.recipe-image');
            recipeImageElement.addEventListener('click', () => {
                fetchRecipeInstructions(recipeId);
            });
        }
    }

    function fetchRecipeInstructions(recipeId) {
        const recipeDetailsUrl = `https://api.spoonacular.com/recipes/${recipeId}/analyzedInstructions?apiKey=${spoonacularAPIKey}`;

        fetch(recipeDetailsUrl)
            .then(response => {
                if (!response.ok) {
                    const errorStatus = response.status;
                    console.log(errorStatus);
                    throw Error("ERROR");
                }
                return response.json();
            })
            .then(data => {
                const instructions = data.length > 0 ? data[0].steps.map(step => step.step) : ['No instructions available.'];

                // Create a container for the instructions
                const instructionsContainer = document.createElement('div');
                instructionsContainer.classList.add('recipe-instructions');

                // Add each instruction as a paragraph
                instructions.forEach(instruction => {
                    const paragraph = document.createElement('p');
                    paragraph.textContent = instruction;
                    instructionsContainer.appendChild(paragraph);
                });

                // Clear previous instructions
                modalBody.innerHTML = '';

                // Display the instructions in a modal
                modalBody.appendChild(instructionsContainer);

                // Show the modal
                modal.style.display = 'block';
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }
});
