// Headers for the applicants table
List<Map<String, String>> applicantTableheaders = [
  {'header': 'Date', 'key': 'date'},
  {'header': 'Applicant name', 'key': 'name'},
  {'header': 'Location', 'key': 'location'},
  {'header': 'Designation', 'key': 'designation'},
  {'header': 'Resume', 'key': 'resume'},
  {'header': 'Status', 'key': 'status'},
];

const // Data for the full table
    List<Map<String, String>> applicantsData = [
  {
    'date': '2023-09-24',
    'name': 'John Doe',
    'location': 'New York',
    'designation': 'Developer',
    'resume': 'View',
    'status': 'SELECTED'
  },
  {
    'date': '2023-09-25',
    'name': 'Jane Smith',
    'location': 'Los Angeles',
    'designation': 'Designer',
    'resume': 'View',
    'status': 'REJECTED'
  },
  {
    'date': '2023-09-24',
    'name': 'John Doe',
    'location': 'New York',
    'designation': 'Developer',
    'resume': 'View',
    'status': 'SELECTED'
  },
  {
    'date': '2023-09-24',
    'name': 'John Doe',
    'location': 'New York',
    'designation': 'Developer',
    'resume': 'View',
    'status': 'SELECTED'
  },
  {
    'date': '2023-09-24',
    'name': 'John Doe',
    'location': 'New York',
    'designation': 'Developer',
    'resume': 'View',
    'status': 'SELECTED'
  },
  {
    'date': '2023-09-24',
    'name': 'John Doe',
    'location': 'New York',
    'designation': 'Developer',
    'resume': 'View',
    'status': 'SELECTED'
  },
];

// Data for the selected applicants table
// List<Map<String, String>> selectedApplicants = [
//   {'name': 'John Doe', 'designation': 'Developer'},
//   {'name': 'Jane Smith', 'designation': 'Designer'},
//   {'name': 'John Doe', 'designation': 'Developer'},
//   {'name': 'Jane Smith', 'designation': 'Designer'},
//   {'name': 'John Doe', 'designation': 'Developer'},
//   {'name': 'Jane Smith', 'designation': 'Designer'},
//   {'name': 'John Doe', 'designation': 'Developer'},
//   {'name': 'Jane Smith', 'designation': 'Designer'},
//   {'name': 'John Doe', 'designation': 'Developer'},
//   {'name': 'Jane Smith', 'designation': 'Designer'},
//   {'name': 'John Doe', 'designation': 'Developer'},
//   {'name': 'Jane Smith', 'designation': 'Designer'},
// ];
//....................................................................
// Headers for the full table
List<Map<String, String>> companyTableHeaders = [
  {'header': 'Date', 'key': 'date'},
  {'header': 'Company name', 'key': 'name'},
  {'header': 'Vaccancy', 'key': 'vaccancy'},
  {'header': 'No.of selected', 'key': 'selected'},
  {'header': 'KBN code', 'key': 'kbn'},
  {'header': 'Status', 'key': 'adminStatus'},
];

// List<Map<String, String>> companyTableData = [
//   {
//     'date': '2024-09-25',
//     'name': 'Tech Solutions Inc.',
//     'location': 'New York, USA',
//     'kbn': 'KBN12345',
//     'link': 'https://example.com/tech-solutions',
//     'payment': 'Paid',
//     'status': 'Active',
//   },
//   {
//     'date': '2024-09-20',
//     'name': 'Global Innovations Ltd.',
//     'location': 'London, UK',
//     'kbn': 'KBN67890',
//     'link': 'https://example.com/global-innovations',
//     'payment': 'Pending',
//     'status': 'Active',
//   },
//   {
//     'date': '2024-09-18',
//     'name': 'Future Enterprises',
//     'location': 'Berlin, Germany',
//     'kbn': 'KBN98765',
//     'link': 'https://example.com/future-enterprises',
//     'payment': 'Paid',
//     'status': 'Inactive',
//   },
//   {
//     'date': '2024-09-15',
//     'name': 'Innovative Solutions',
//     'location': 'Tokyo, Japan',
//     'kbn': 'KBN54321',
//     'link': 'https://example.com/innovative-solutions',
//     'payment': 'Paid',
//     'status': 'Active',
//   },
// ];

// // Data for the approved  companies table
// List<Map<String, String>> apprvedCompanies = [
//   {'name': 'Luma solutions', 'website': 'www.Luma.com'},
//   {'name': 'Festa solutions', 'website': 'www.festa.com'},
//   {'name': 'rebeca solutions', 'website': 'www.rebeca.com'},
//   {'name': 'inbuilta solutions', 'website': 'www.inbuilta.com'},
//   {'name': 'indica technologies', 'website': 'www.indica.com'},
//   {'name': 'rebel technologys', 'website': 'www.rebel.com'},
//   {'name': 'zigma pvt ltd', 'website': 'www.zigma.com'},
// ];

// Data for the approved  companies table
List<Map<String, String>> companyTransactionData = [
  {
    'name': 'Luma solutions',
    'amount': '15000',
    'payment': 'Payed',
    'status': 'status'
  },
  {
    'name': 'Luma solutions',
    'amount': '15000',
    'payment': 'Unpaid',
    'status': 'status'
  },
  {
    'name': 'Luma solutions',
    'amount': '15000',
    'payment': 'Payed',
    'status': 'status'
  },
  {
    'name': 'Luma solutions',
    'amount': '15000',
    'payment': 'Unpaid',
    'status': 'status'
  },
  {
    'name': 'Luma solutions',
    'amount': '15000',
    'payment': 'Payed',
    'status': 'status'
  },
];

//---------------------------------------------------
//Default Data

List<Map<String, String>> defaultCardData = [
  {
    'title': "",
    'subTitle': "Company position on this month",
  },
  {
    'title': '',
    'subTitle': "Applicants applied this month",
  },
  {
    'title': '',
    'subTitle': "Applicants have got jobs",
  },
  {
    'title': '',
    'subTitle': 'Applicants for Python Jobs',
  },
  {
    'title': '',
    'subTitle': "Total growth on this month",
  },
];

List<Map<String, String>> defaultAdminCardData = [
  {
    'title': '',
    'subTitle': "Best Company on This Month",
  },
  {
    'title': '',
    'subTitle': "Company added on this month",
  },
  {
    'title': '',
    'subTitle': "Companies has got Kbn Code",
  },
  {
    'title': '',
    'subTitle': "Most Applied Company",
  },
  {
    'title': '',
    'subTitle': "Total Growth on this month",
  },
];

List<Map<String, String>> defaultStatisticTableData = [
  {'Name': "name", "Percentage": "Percentage"},
];
