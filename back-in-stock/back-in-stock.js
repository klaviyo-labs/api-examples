// this file contains all JavaScript used in the back in stock API video, including the API request itself. In the example video, this is added to a script tag within a Shopify liquid file.
window.addEventListener("DOMContentLoaded", (e) => {
    const notify_btn = document.getElementById("notify-button")
    const bis_form = document.getElementById("bis-form");
    
    notify_btn.addEventListener('click',function(e) {
      e.preventDefault();
      bis_form.style.display="block"
    })
  
      const variant_id = {{ product.variants[0].id }}
    
    bis_form.addEventListener("submit", function (event) {
      event.preventDefault();
      let customer_email = document.getElementById('bis_input').value;
    
      const options = {
        method: "POST",
        headers: {
          accept: "application/vnd.api+json",
          revision: "2025-01-15",
          "content-type": "application/vnd.api+json",
        },
        body: `{"data": {"type": "back-in-stock-subscription","attributes": {"channels": ["EMAIL"],"profile": {"data": {"type": "profile","attributes": {"email": "${customer_email}"}}}},"relationships": {"variant": {"data": {"type": "catalog-variant","id": "$shopify:::$default:::${variant_id}"}}}}}`,
      };
      const url = 'https://a.klaviyo.com/client/back-in-stock-subscriptions/?company_id=RU8Lmz';
      fetch(url, options)
        .then((res) => console.log(res))
        .catch((err) => console.error(err));
      bis_form.style.display = "none";
      document.getElementById("success_message").style.display="block"
    });
})