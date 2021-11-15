# Assignment 2 - Contacts App

## Problem Statement

Create a mobile app for managing the contacts. App should allow user to save the contact details in local database along with the photo. User can see contact list and can modify/delete any contact. Also, user can favorite/unfavorite contacts and can see list of favorite contacts. Below are the detailed requirements.

## Requirements

| Screen  | Use case | Details |
| --- | --- | --- |
| Contact list screen | User can see list of contacts in ascending order by name | 1. 	Screen has the title `Contact List`
2. Show list of contacts with contact name and photo saved in ascending order
3. This screen will have a `add` button at the bottom right of the screen. Pressing this button will take user to `Create new contact screen`
4. In contact list, by clicking on any contact, user will navigate to `Update contact screen` |
| Create new contact screen | User can add a new contact | 1. Screen has the title `Add New Contact`
2. Following are the input fields:
   - Name of person
   - Mobile phone number
   - Landline number
   - Take/Browse photo of person
3. Favorite button to mark/unmark the contact as favorite
4. Save button to save the contact and navigate to contact list screen |
| Update contact screen | User can update contact details | 1. Screen has the title `Update Contact` and will show details of selected contact
2. Following are the input fields:
   - Name of person
   - Mobile phone number
   - Landline number
   - Take/Browse photo of person
3. Update button to update the contact details
4. Favorite button to mark/unmark the contact as favorite
5. Delete button to delete the contact |
| Favorite contact list screen | User can see list of favorite contacts | 1. Screen has the title `Favorite Contact List`
2. List of favorite contacts in ascending order |
| App Navigation | User can navigate between the screens | 1. App will have a sliding drawer with options:
   - Contact list screen
   - Favorite contacts
   - Add new contact
2. Clicking on any of these options will navigate user to corresponding screen |

## Technical Requirements

1. App should use BLoC architecture
2. App should use ‘Drawer’ for sliding drawer
3. App should use ‘ListView’ to show contact list items
4. App should use local database for CRUD operations
