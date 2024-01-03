# Import libraries
import streamlit as st
import os
import base64

# Set the title of the app
st.title("PDF to HTML Converter")

# Create a file uploader widget
uploaded_file = st.file_uploader("Upload a PDF file", type="pdf")

# Check if a file is uploaded
if uploaded_file is not None:
    # Get the file name
    file_name = uploaded_file.name
    # Create a file path in the /tmp directory
    file_path = os.path.join("/tmp", file_name)
    # Save the file to the /tmp directory
    with open(file_path, "wb") as f:
        f.write(uploaded_file.getbuffer())
    # Run the pdf2htmlEX command
    os.system(f"pdf2htmlEX --zoom 1.3 {file_path}")
    # Read the output html file
    with open(f"{file_path}.html", "rb") as f:
        html_data = f.read()
    # Encode the html file to base64
    b64 = base64.b64encode(html_data).decode()
    # Create a download link for the html file
    href = f'<a href="data:file/html;base64,{b64}" download="{file_name}.html">Download HTML file</a>'
    # Display the download link
    st.markdown(href, unsafe_allow_html=True)