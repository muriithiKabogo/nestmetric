function setOutcome(e){var t=document.querySelector(".success"),r=document.querySelector(".error");t.classList.remove("visible"),r.classList.remove("visible"),e.token?(t.querySelector(".token").textContent=e.token.id,t.classList.add("visible")):e.error&&(r.textContent=e.error.message,r.classList.add("visible"))}var stripe=Stripe("pk_test_afXp5UfeGca02PSLmJ5gnqEf"),elements=stripe.elements(),card=elements.create("card",{style:{base:{iconColor:"#666EE8",color:"#31325F",lineHeight:"40px",fontWeight:300,fontFamily:'"Helvetica Neue", Helvetica, sans-serif',fontSize:"15px","::placeholder":{color:"#CFD7E0"}}}});card.mount("#card-element"),card.on("change",function(e){setOutcome(e)}),document.querySelector("form").addEventListener("submit",function(e){e.preventDefault();var t=document.querySelector("form"),r={name:t.querySelector("input[name=cardholder-name]").value};stripe.createToken(card,r).then(setOutcome)});