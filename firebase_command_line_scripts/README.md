To use the functionalities in this directory, follow these steps:

### Prerequisites
- Ensure you have `node` and `npm` installed on your system. 
- Download and copy the `data` directory to the root of your project.

### Data Directory Structure

- **quests/**
  - **actor-1885.json**
  - **actor-1955.json**
  - **actor-1985.json**
  - **actor-2015.json**
  - **community.json**
  - **quiz.json**
  - **social.json**
- **read/**
  - **assignable_points.json**
  - **configurations.json**
  - **staff_users.json**
- **assignable_points.json**
- **configurations.json**
- **staff_users.json**


### Install Dependencies
First, install the necessary dependencies by running:
```sh
npm install
```

### Available Script
The `package.json` file defines a script named `execute`:
```json
"scripts": {
  "execute": "node ./src/index.js"
}
```

### Running the Script
To run the script, use the following command:
```sh
npm run execute
```

### Script Functionalities
The script in `src/index.js` provides a multi-step process where you can select which steps to run. The available steps are:
1. **Initialize configurations**: Initializes the necessary configurations.
2. **Create users**: Creates user accounts.
3. **Upload quests**: Uploads quest data.
4. **Deploy functions**: Deploys Firebase functions.

When you run the script, you will be prompted to select the steps you want to execute. You can choose to run all steps or select specific ones.

### Example Usage
1. Run the script:
   ```sh
   npm run execute
   ```
   ![image_1.png](images%2Fimage_1.png)

2. Select the steps you want to run from the prompt.
![image_2.png](images%2Fimage_2.png)

3. The script will execute the selected steps sequentially, providing feedback in the console.
![image_3.png](images%2Fimage_3.png)