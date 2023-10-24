import { createClient } from '@supabase/supabase-js'

const supabaseUrl = 'https://sphfcqvviegsxucwhmas.supabase.co'
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNwaGZjcXZ2aWVnc3h1Y3dobWFzIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgwNDQ0MTAsImV4cCI6MjAxMzYyMDQxMH0.o042XLA5chkuhNHcPytKI6sZ6ZeYHOzb-_ZXgDJ0hp8'

export const supabase = createClient(supabaseUrl, supabaseKey)
