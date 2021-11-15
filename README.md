# Assignment 2 - Contacts App

## Problem Statement

Create a mobile app for managing the contacts. App should allow user to save the contact details in local database along with the photo. User can see contact list and can modify/delete any contact. Also, user can favorite/unfavorite contacts and can see list of favorite contacts. Below are the detailed requirements.

## Requirements

| Screen  | Use case | Details |
| --- | --- | --- |
| Contact list screen | User can see list of contacts in ascending order by name | 1. Screen has the title `Contact List` <br> 2. Show list of contacts with contact name and photo saved in ascending order <br> 3. This screen will have a `add` button at the bottom right of the screen. Pressing this button will take user to `Create new contact screen` <br> 4. In contact list, by clicking on any contact, user will navigate to `Update contact screen` |
| Create new contact screen | User can add a new contact | 1. Screen has the title `Add New Contact` <br> 2. Following are the input fields: <br>  - Name of person <br>  - Mobile phone number <br>  - Landline number <br>  - Take/Browse photo of person <br> 3. Favorite button to mark/unmark the contact as favorite <br> 4. Save button to save the contact and navigate to contact list screen |
| Update contact screen | User can update contact details | 1. Screen has the title `Update Contact` and will show details of selected contact <br> 2. Following are the input fields: <br>  - Name of person <br>  - Mobile phone number <br>  - Landline number <br>  - Take/Browse photo of person <br> 3. Update button to update the contact details <br> 4. Favorite button to mark/unmark the contact as favorite <br> 5. Delete button to delete the contact |
| Favorite contact list screen | User can see list of favorite contacts | 1. Screen has the title `Favorite Contact List` <br> 2. List of favorite contacts in ascending order |
| App Navigation | User can navigate between the screens | 1. App will have a sliding drawer with options: <br>  - Contact list screen <br>  - Favorite contacts <br>  - Add new contact <br> 2. Clicking on any of these options will navigate user to corresponding screen |

## Technical Requirements

1. App should use BLoC architecture
2. App should use ‘Drawer’ for sliding drawer
3. App should use ‘ListView’ to show contact list items
4. App should use local database for CRUD operations
