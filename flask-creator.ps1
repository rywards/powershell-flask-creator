# create a boilerplate flask project
# author: https://github.com/rywards
# Version: 1.0
# Date: 9/15/2024
function Get-HTML {

    return @"
<!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="stylesheet" href="{{ url_for('static', filename='style.css') }}">
    </head>
    <body>
        <div class="content">
            <ul>
                <li>
                    <img src="https://flask.palletsprojects.com/en/3.0.x/_static/flask-vertical.png">
                </li>
                <li>
                    You just created a Flask project!
                </li>
                <li>
                    Check out my <a target="_blank" href="https://github.com/rywards">github</a> for updates and more.
                </li>
            </ul>
        </div>
    </body>
</html>
"@
}

function Get-Style {
    return @"
html, body {
    height: 100%;
    margin: 0;
}
ul {
    font-size: xx-large;
    text-align: center;
}

li {
    list-style: none;
}

.content {
    display: flex;
    justify-content: center; /* Horizontal centering */
    align-items: center;     /* Vertical centering */
    height: 100vh;           /* Full viewport height */
}
"@

}

function Get-App {
    return @"
from flask import Flask
from flask import render_template

app = Flask(__name__)

@app.route("/")
def hello_world():
    return render_template('home.html')
"@
}


$projectname=Read-Host "Project directory name"
$rootlocation=(Get-Location).Path
$projectdirectory = Join-Path $rootlocation -ChildPath $projectname
$templates = Join-Path $projectdirectory -ChildPath "templates"
$static = Join-Path $projectdirectory -ChildPath "static"
$html = Get-HTML
$style = Get-Style
$app = Get-App

# create project directory
New-Item -Path $rootlocation -Name $projectname -ItemType "directory"

Set-Location $projectdirectory

# create templates and static paths
Write-Output "Creating files..."

# Create directories
New-Item -Path $templates -ItemType "directory"
New-Item -Path $static -ItemType "directory"

# Create files directly in their respective directories
New-Item -Path "$templates\home.html" -ItemType File -Value $html
New-Item -Path "$static\style.css" -ItemType File -Value $style
New-Item -Path "$projectdirectory\app.py" -ItemType File -Value $app
New-Item -Path "$projectdirectory\.env" -ItemType File

Write-Output "Files created successfully."

# set up virtual environment
Write-Output "Creating virtual environment..."
& "python.exe" -m venv .venv

Write-Output "Activating virtual environment..."
& .\.venv\Scripts\activate

Write-Output "Installing Flask to virtual environment..."
& pip install Flask

Write-Output "Deadtivating venv..."
& deactivate

Write-Output "Returning to root directory..."
Set-Location $rootlocation