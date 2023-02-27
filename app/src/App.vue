<script setup lang="ts">
// https://github.com/vueuse/head
// you can use this to manipulate the document head in any components,
// they will be rendered correctly in the html results with vite-ssg
const title = 'Carlos Soriano'
const description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, nisl nec ultricies lacinia, nunc nisl aliquam massa, eget aliquam nisl nisl eu ante. Sed euismod, nisl nec ultricies lacinia, nunc nisl aliquam massa, eget aliquam nisl nisl eu ante. Sed euismod, nisl nec ultricies lacinia, nunc nisl aliquam massa, eget aliquam nisl nisl eu ante. Sed euismod, nisl nec ultricies lacinia, nunc nisl aliquam massa, eget aliquam nisl nisl eu ante. Sed euismod, nisl nec ultricies lacinia, nunc nisl aliquam massa, eget aliquam nisl nisl eu ante. Sed euismod, nisl nec ultricies lacinia, nunc nisl aliquam massa, eget aliquam nisl nisl eu ante. Sed euismod, nisl nec ultricies lacinia, nunc nisl aliquam massa, eget aliquam nisl nisl eu ante. Sed euismod, nisl nec ultricies lacinia, nunc nisl aliquam massa, eget aliquam nisl nisl eu ante. Sed euismod, nisl nec ultricies lacinia, nunc nisl aliquam massa, eget aliquam nisl nisl eu ante. Sed euismod, nisl nec ultricies lacinia, nunc nisl aliquam massa, eget aliquam nisl nisl eu ante. Sed euismod, nisl nec ultricies lacinia, nunc nisl aliquam massa, eget aliquam nisl nisl eu ante. Sed euismod, nisl nec ultricies lacinia, nunc nisl aliquam massa, eget aliquam nisl nisl eu ante. Sed euismod, nisl nec ultricies lacinia, nunc nisl aliquam massa, eget aliquam nisl nisl eu ante. Sed euismod, nisl nec ultricies lacinia, nunc nisl aliquam massa, eget aliquam nisl nisl eu ante. Sed euismod, nisl nec ultricies lacinia, nunc nisl aliquam massa, eget aliquam nisl nisl eu ante. Sed euismod, nisl nec ultricies lacin'
const image = "https://dev.marshmallowmeat.com/pwa-512x512.png"
useHead({
  title: title,
  meta: [
    { name: 'description', content: description },
    { property: 'og:title', content: title },
    { property: 'og:description', content: description },
    { property: 'og:image', content: image },
    // { property: 'og:image:alt', content: imageAlt },
    // { property: 'og:image:type', content: imageType },
    { property: 'og:image:width', content: '1200' },
    { property: 'og:image:height', content: '630' },
    // { property: 'og:url', content: url },
    // { property: 'og:site_name', content: title },
    // { property: 'og:locale', content: 'en_US' },
    // { property: 'og:type', content: 'website' },
    // { name: 'twitter:card', content: 'summary_large_image' },
    // { name: 'twitter:site', content: twitterHandle },
    // { name: 'twitter:creator', content: twitterHandle },
    // { name: 'twitter:title', content: title },
    // { name: 'twitter:description', content: description },
    // { name: 'twitter:image', content: image },
    // { name: 'twitter:image:alt', content: imageAlt },
    // { name: 'twitter:image:width', content: '1200' },
    // { name: 'twitter:image:height', content: '630' },
    // { name: 'twitter:domain', content: host },
    // { name: 'twitter:label1', content: 'Written by' },
    // { name: 'twitter:data1', content: author },
    // { name: 'twitter:label2', content: 'Est. reading time' },
    // { name: 'twitter:data2', content: '5 minutes' },
    // { name: 'twitter:label3', content: 'Filed under' },
    // { name: 'twitter:data3', content: 'Blog' },
    // { name: 'twitter:label4', content: 'Last updated' },
    // { name: 'twitter:data4', content: 'June 1, 2021' },
    // { name: 'twitter:label5', content: 'First published' },
    // { name: 'twitter:data5', content: 'June 1, 2021' },
    // { name: 'twitter:label6', content: 'Language' },
    // { name: 'twitter:data6', content: 'English' },
    {
      name: 'theme-color',
      content: computed(() => isDark.value ? '#00aba9' : '#ffffff'),
    },
  ],
  link: [
    {
      rel: 'icon',
      type: 'image/svg+xml',
      href: computed(() => preferredDark.value ? '/favicon-dark.svg' : '/favicon.svg'),
    },
    {
      rel: 'canonical',
      href: computed(() => import.meta.env.BASE_URL),
    }
  ],
})
</script>

<template>
  <RouterView />
</template>
